<?php

namespace App\Http\Controllers;

use App\Models\Plant;
use Dedoc\Scramble\Attributes\Endpoint;
use Dedoc\Scramble\Attributes\Group;
use Illuminate\Http\Request;

#[Group(
    name: 'Plants',
    description: 'Browse the plant catalog, inspect individual plant details, and create new plant records.',
)]
class PlantController extends Controller
{
    #[Endpoint(
        title: 'List plants',
        description: 'Return all plants with their category details and optional filters for search, region, season, and category.',
    )]
    public function index()
    {
        $plants = Plant::query()
            ->with('category') // جلب بيانات الفئة مع النبتة
            ->search(request('search')) // فلترة بالاسم
            ->byRegion(request('region')) // فلترة بالمنطقة
            ->bySeason(request('season')) // فلترة بالفصل
            ->when(request('category_id'), function ($query) {
                $query->where('category_id', request('category_id'));
            })
            ->get();

        return response()->json(['data' => $plants, 'status' => 'success']);
    }

    #[Endpoint(
        title: 'Get plant details',
        description: 'Retrieve a single plant record and resolve its full storage image URL for display.',
    )]
    public function show(Plant $plant)
    {
        // استرجاع النبات المحدد من قاعدة البيانات
        $plant = Plant::where('id', $plant->id)->first();

        if (!$plant) {
            return response()->json(['message' => 'Plant not found!'], 404);
        }

        // إضافة الرابط الكامل للصورة
        $plant->image_url = $plant->image
            ? asset('storage/' . $plant->image)
            : null;

        return response()->json(['data' => $plant, 'status' => 'success']);
    }

    #[Endpoint(
        title: 'Create a plant',
        description: 'Create a new plant record with localized names, growing requirements, and an optional uploaded image.',
    )]
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            // المعلومات الأساسية
            'name_ar' => 'required|string|max:150',
            'name_en' => 'nullable|string|max:150',
            'region_name_ar' => 'required|string|max:100',
            'region_name_en' => 'required|string|max:100',
            'season' => 'required|string|max:150',
            'category_id' => 'required|exists:categories,id',
            'description_ar' => 'nullable|string',
            'description_en' => 'nullable|string',
            'image' => 'nullable|image|max:2048', // الحد الأقصى 2 ميجابايت

            // التربة
            'soil_type_ar' => 'nullable|string|max:200',
            'soil_type_en' => 'nullable|string|max:200',
            'soil_ph_min' => 'nullable|numeric|min:0|max:14',
            'soil_ph_max' => 'nullable|numeric|min:0|max:14|gte:soil_ph_min', // يجب أن يكون أكبر من أو يساوي الحد الأدنى

            // المياه
            'water_amount_mm' => 'nullable|integer|min:0',
            'watering_frequency' => 'nullable|string|max:50',

            // الحرارة والرطوبة
            'temp_min_c' => 'nullable|numeric',
            'temp_max_c' => 'nullable|numeric|gte:temp_min_c',
            'humidity_min' => 'nullable|integer|min:0|max:100',
            'humidity_max' => 'nullable|integer|min:0|max:100|gte:humidity_min',

            // الشمس
            'sun_hours_min' => 'nullable|integer|min:0|max:24',
            'sun_hours_max' => 'nullable|integer|min:0|max:24|gte:sun_hours_min',

            // التقويم الزراعي (من 1 إلى 12)
            'planting_start_month' => 'nullable|integer|min:1|max:12',
            'planting_end_month' => 'nullable|integer|min:1|max:12',
            'harvest_start_month' => 'nullable|integer|min:1|max:12',
            'harvest_end_month' => 'nullable|integer|min:1|max:12',

            // المسافات والنصوص
            'spacing_cm' => 'nullable|integer|min:0',
            'fertilization_notes' => 'nullable|string',
            'common_diseases' => 'nullable|string',
        ]);

        // معالجة الصورة إذا تم رفعها
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('plants', 'public');
            $validatedData['image'] = $imagePath;
        }

        // إنشاء النبات
        $plant = Plant::create($validatedData);

        return response()->json(['data' => $plant, 'status' => 'success'], 201);
    }
}
