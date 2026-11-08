<?php

namespace App\Http\Controllers;

use App\Models\Plant;
use Illuminate\Http\Request;

class PlantController extends Controller
{
    public function index()
    {
        // استرجاع جميع النباتات من قاعدة البيانات
        $plants = Plant::all();

        // إضافة الرابط الكامل لكل صورة
        $plants->each(function ($plant) {
            $plant->image_url = $plant->image
                ? asset('storage/' . $plant->image)
                : null;
        });

        return response()->json(['data' => $plants, 'status' => 'success']);
    }

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

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name_ar' => 'required|string|max:150',
            'name_en' => 'nullable|string|max:150',
            'category_id' => 'required|exists:categories,id',
            'description_ar' => 'nullable|string',
            'description_en' => 'nullable|string',
            'image' => 'nullable|image|max:2048', // تحقق من أن الملف صورة ولا يتجاوز 2 ميغابايت
            'season' => 'required|string|max:150',
        ]);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('plants', 'public');
            $validatedData['image'] = $imagePath;
        }

        $plant = Plant::create($validatedData);

        return response()->json(['data' => $plant, 'status' => 'success'], 201);
    }
}
