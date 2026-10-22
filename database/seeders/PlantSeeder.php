<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PlantSeeder extends Seeder
{
    public function run(): void
    {
        \App\Models\Plant::insert([
            [
                'name_ar' => 'بندورة',
                'name_en' => 'Tomato',
                'category' => 'خضار',
                'description' => 'من أشهر محاصيل الخضار، يحتاج إلى شمس كاملة وري منتظم.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name_ar' => 'زيتون',
                'name_en' => 'Olive',
                'category' => 'أشجار مثمرة',
                'description' => 'شجرة معمرة تتحمل الجفاف، من أهم محاصيل سوريا.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name_ar' => 'نعنع',
                'name_en' => 'Mint',
                'category' => 'أعشاب',
                'description' => 'عشبة عطرية سريعة النمو، تحتاج رطوبة عالية.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
