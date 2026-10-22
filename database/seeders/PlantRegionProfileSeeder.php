<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PlantRegionProfileSeeder extends Seeder
{
    public function run(): void
    {
        $tomato = \App\Models\Plant::where('name_ar', 'بندورة')->first();
        $aleppo = \App\Models\Region::where('name_ar', 'حلب')->first();

        \App\Models\PlantRegionProfile::create([
            'plant_id' => $tomato->id,
            'region_id' => $aleppo->id,
            'soil_type' => 'طينية رملية جيدة الصرف',
            'soil_ph_min' => 6.0,
            'soil_ph_max' => 7.0,
            'water_amount_mm' => 40,
            'watering_frequency' => 'مرتين أسبوعياً',
            'temp_min_c' => 18.0,
            'temp_max_c' => 30.0,
            'humidity_min' => 60,
            'humidity_max' => 80,
            'sun_hours_min' => 6,
            'sun_hours_max' => 8,
            'planting_start_month' => 3,
            'planting_end_month' => 4,
            'harvest_start_month' => 7,
            'harvest_end_month' => 9,
            'spacing_cm' => 50,
            'fertilization_notes' => 'سماد NPK 20-20-20 كل أسبوعين بعد الإزهار.',
            'common_diseases' => 'اللفحة المتأخرة، الذبول الفيوزاريومي، التوتا أبسولوتا.',
        ]);
    }
}
