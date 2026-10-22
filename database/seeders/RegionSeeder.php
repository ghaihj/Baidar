<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RegionSeeder extends Seeder
{
    public function run(): void
    {
        \App\Models\Region::insert([
            ['name_ar' => 'حلب', 'name_en' => 'aleppo', 'climate_zone' => 'شبه جاف', 'created_at' => now(), 'updated_at' => now()],
            ['name_ar' => 'حمص', 'name_en' => 'aleppo', 'climate_zone' => 'شبه جاف', 'created_at' => now(), 'updated_at' => now()],
            ['name_ar' => 'الساحل', 'name_en' => 'aleppo', 'climate_zone' => 'متوسطي رطب', 'created_at' => now(), 'updated_at' => now()],
            ['name_ar' => 'الجزيرة', 'name_en' => 'aleppo', 'climate_zone' => 'شبه جاف', 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
