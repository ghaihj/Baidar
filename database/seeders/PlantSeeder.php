<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Plant;
use App\Models\Category;

class PlantSeeder extends Seeder
{
    public function run(): void
    {
        // 1. جلب الفئات أو إنشائها تلقائياً إذا لم تكن موجودة
        $veggies = Category::firstOrCreate(
            ['name_en' => 'Vegetables'],
            ['name_ar' => 'خضار']
        )->id;

        $fruits = Category::firstOrCreate(
            ['name_en' => 'Fruit Trees'],
            ['name_ar' => 'أشجار مثمرة']
        )->id;

        $herbs = Category::firstOrCreate(
            ['name_en' => 'Herbs'], // جربت هنا استخدام Herbs، وهو الاسم الشائع
            ['name_ar' => 'أعشاب']
        )->id;

        // 1. بندورة (المنطقة الوسطى - صيف)
        Plant::create([
            'name_ar' => 'بندورة',
            'name_en' => 'Tomato',
            'region_name_ar' => 'الوسطى',
            'region_name_en' => 'Central',
            'season' => 'صيف',
            'category_id' => $veggies,
            'description_ar' => 'من أشهر محاصيل الخضار، يحتاج إلى شمس كاملة وري منتظم.',
            'description_en' => 'One of the most popular vegetable crops, needs full sun and regular watering.',
            'soil_type_ar' => 'طينية رملية جيدة الصرف',
            'soil_type_en' => 'Sandy loam, well-drained',
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

        // 2. زيتون (المنطقة الشمالية - شتاء)
        Plant::create([
            'name_ar' => 'زيتون',
            'name_en' => 'Olive',
            'region_name_ar' => 'الشمالية',
            'region_name_en' => 'Northern',
            'season' => 'شتاء',
            'category_id' => $fruits,
            'description_ar' => 'شجرة معمرة تتحمل الجفاف، من أهم محاصيل سوريا.',
            'description_en' => 'A perennial drought-tolerant tree, one of the most important crops in Syria.',
            'soil_type_ar' => 'كلسية جيدة التصريف',
            'soil_type_en' => 'Calcareous, well-drained',
            'soil_ph_min' => 7.0,
            'soil_ph_max' => 8.5,
            'water_amount_mm' => 20,
            'watering_frequency' => 'مرة كل 15 يوم',
            'temp_min_c' => 5.0,
            'temp_max_c' => 35.0,
            'humidity_min' => 30,
            'humidity_max' => 60,
            'sun_hours_min' => 8,
            'sun_hours_max' => 10,
            'planting_start_month' => 11,
            'planting_end_month' => 2,
            'harvest_start_month' => 10,
            'harvest_end_month' => 12,
            'spacing_cm' => 600,
            'fertilization_notes' => 'سماد نيتروجيني في الربيع، وبوتاسيوم قبل الحصاد.',
            'common_diseases' => 'ذبول الفيرتيسيليوم، عين الطاووس.',
        ]);

        // 3. نعنع (المنطقة الساحلية - ربيع)
        Plant::create([
            'name_ar' => 'نعنع',
            'name_en' => 'Mint',
            'region_name_ar' => 'الساحلية',
            'region_name_en' => 'Coastal',
            'season' => 'ربيع',
            'category_id' => $herbs,
            'description_ar' => 'عشبة عطرية سريعة النمو، تحتاج رطوبة عالية.',
            'description_en' => 'A fast-growing aromatic herb that requires high humidity.',
            'soil_type_ar' => 'طينية غنية بالمادة العضوية',
            'soil_type_en' => 'Clay rich in organic matter',
            'soil_ph_min' => 5.5,
            'soil_ph_max' => 7.0,
            'water_amount_mm' => 30,
            'watering_frequency' => 'كل يومين',
            'temp_min_c' => 15.0,
            'temp_max_c' => 25.0,
            'humidity_min' => 70,
            'humidity_max' => 90,
            'sun_hours_min' => 4,
            'sun_hours_max' => 6,
            'planting_start_month' => 2,
            'planting_end_month' => 4,
            'harvest_start_month' => 5,
            'harvest_end_month' => 10,
            'spacing_cm' => 20,
            'fertilization_notes' => 'سماد عضوي سائل كل أسبوعين.',
            'common_diseases' => 'الصدأ، البياض الدقيقي.',
        ]);

        // 4. خيار (المنطقة الجنوبية - صيف)
        Plant::create([
            'name_ar' => 'خيار',
            'name_en' => 'Cucumber',
            'region_name_ar' => 'الجنوبية',
            'region_name_en' => 'Southern',
            'season' => 'صيف',
            'category_id' => $veggies,
            'description_ar' => 'يحتاج إلى دعامات للتسلق وري منتظم.',
            'description_en' => 'Requires trellises for climbing and regular watering.',
            'soil_type_ar' => 'رملية طينية',
            'soil_type_en' => 'Sandy clay',
            'soil_ph_min' => 6.0,
            'soil_ph_max' => 7.0,
            'water_amount_mm' => 35,
            'watering_frequency' => '3 مرات أسبوعياً',
            'temp_min_c' => 20.0,
            'temp_max_c' => 32.0,
            'humidity_min' => 60,
            'humidity_max' => 80,
            'sun_hours_min' => 6,
            'sun_hours_max' => 8,
            'planting_start_month' => 4,
            'planting_end_month' => 5,
            'harvest_start_month' => 6,
            'harvest_end_month' => 8,
            'spacing_cm' => 40,
            'fertilization_notes' => 'سماد متوازن كل أسبوعين.',
            'common_diseases' => 'البياض الدقيقي، الأنثراكنوز.',
        ]);
    }
}
