<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Plant;
use App\Models\Category;

class PlantSeeder extends Seeder
{
    public function run(): void
    {
        // جلب معرفات الفئات
        $veggies = Category::where('name_en', 'Vegetables')->first()->id;
        $fruits  = Category::where('name_en', 'Fruit Trees')->first()->id;
        $herbs   = Category::where('name_en', 'Herbs')->first()->id;

        Plant::insert([
            [
                'name_ar' => 'بندورة',
                'name_en' => 'Tomato',
                'category_id' => $veggies, // ربط ديناميكي
                'description' => 'من أشهر محاصيل الخضار، يحتاج إلى شمس كاملة وري منتظم.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name_ar' => 'زيتون',
                'name_en' => 'Olive',
                'category_id' => $fruits,
                'description' => 'شجرة معمرة تتحمل الجفاف، من أهم محاصيل سوريا.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name_ar' => 'نعنع',
                'name_en' => 'Mint',
                'category_id' => $herbs,
                'description' => 'عشبة عطرية سريعة النمو، تحتاج رطوبة عالية.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name_ar' => 'خيار',
                'name_en' => 'Cucumber',
                'category_id' => $veggies,
                'description' => 'يحتاج إلى دعامات للتسلق وري منتظم.',
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);
    }
}
