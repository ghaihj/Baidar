<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{

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
