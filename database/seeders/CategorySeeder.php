<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Category;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        Category::insert([
            ['name_ar' => 'خضار', 'name_en' => 'Vegetables', 'created_at' => now(), 'updated_at' => now()],
            ['name_ar' => 'أشجار مثمرة', 'name_en' => 'Fruit Trees', 'created_at' => now(), 'updated_at' => now()],
            ['name_ar' => 'أعشاب', 'name_en' => 'Herbs', 'created_at' => now(), 'updated_at' => now()],
            ['name_ar' => 'زينة', 'name_en' => 'Ornamental', 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
