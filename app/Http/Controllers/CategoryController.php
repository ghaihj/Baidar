<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Dedoc\Scramble\Attributes\Endpoint;
use Dedoc\Scramble\Attributes\Group;
use Illuminate\Http\Request;

#[Group(
    name: 'Categories',
    description: 'Browse plant categories, inspect category details, and retrieve the plants linked to each category.',
)]
class CategoryController extends Controller
{
    #[Endpoint(
        title: 'List all categories',
        description: 'Return the full list of plant categories, including optional search filtering by category name.',
    )]
    public function index()
    {
        // قراءة معاملات البحث من الرابط (مثلاً: ?search=Tomato)
        $search = request('search');

        // جلب الفئات مع تطبيق الفلترة
        $categories = Category::query()
            ->when($search, function ($query, $search) {
                // البحث في الاسم العربي أو الإنجليزي
                $query->where(function ($q) use ($search) {
                    $q->where('name_ar', 'like', "%{$search}%")
                        ->orWhere('name_en', 'like', "%{$search}%");
                });
            })
            ->get();

        // إضافة الرابط الكامل لكل صورة
        $categories->each(function ($category) {
            $category->image_url = $category->image
                ? asset('storage/' . $category->image)
                : null;
        });

        return response()->json(['data' => $categories, 'status' => 'success']);
    }


    #[Endpoint(
        title: 'Create a category',
        description: 'Create a new plant category with a localized name and optional image upload.',
    )]
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name_ar' => 'required|string|max:150|unique:categories,name_ar',
            'name_en' => 'nullable|string|max:150|unique:categories,name_en',
            'image' => 'nullable|image|max:2048', // تحقق من أن الملف صورة ولا يتجاوز 2 ميغابايت
        ]);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('categories', 'public');
            $validatedData['image'] = $imagePath;
        }

        $category = Category::create($validatedData);

        return response()->json(['data' => $category, 'status' => 'success'], 201);
    }


    #[Endpoint(
        title: 'Get category details',
        description: 'Retrieve a single category together with its related plants and a full image URL.',
    )]
    public function show(Category $category)
    {
        $category = Category::with('plants')->where('id', $category->id)->first();

        // إضافة الرابط الكامل للصورة
        $category->image_url = $category->image
            ? asset('storage/' . $category->image)
            : null;

        if (!$category) {
            return response()->json(['message' => 'category not found!'], 404);
        }

        return response()->json(['data' => $category, 'status' => 'success']);
    }

    #[Endpoint(
        title: 'List plants in a category',
        description: 'Fetch all plants associated with a specific category and attach their full image URLs.',
    )]
    public function plantsCategory(Category $category)
    {
        $categories = Category::with('plants')->where('id', $category->id)->first();

        // إضافة الرابط الكامل للصورة
        $categories->plants->each(function ($plant) {
            $plant->image_url = $plant->image
                ? asset('storage/' . $plant->image)
                : null;
        });

        return response()->json(['data' => $categories, 'status' => 'success']);
    }

    public function update(Request $request, Category $category)
    {
        //
    }

    public function destroy(Category $category)
    {
        //
    }
}
