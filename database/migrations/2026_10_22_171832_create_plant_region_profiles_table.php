<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('plant_region_profiles', function (Blueprint $table) {
            $table->id();

            // العلاقات
            $table->foreignId('plant_id')->constrained()->cascadeOnDelete();
            $table->foreignId('region_id')->constrained()->cascadeOnDelete();

            // التربة
            $table->string('soil_type', 200)->nullable()->comment('نوع التربة المناسب');
            $table->decimal('soil_ph_min', 3, 1)->nullable()->comment('الحد الأدنى للحموضة');
            $table->decimal('soil_ph_max', 3, 1)->nullable()->comment('الحد الأعلى للحموضة');

            // المياه
            $table->integer('water_amount_mm')->nullable()->comment('كمية الري الأسبوعية (مم)');
            $table->string('watering_frequency', 50)->nullable()->comment('عدد مرات الري');

            // الحرارة والرطوبة
            $table->decimal('temp_min_c', 4, 1)->nullable()->comment('الحد الأدنى لدرجة الحرارة');
            $table->decimal('temp_max_c', 4, 1)->nullable()->comment('الحد الأعلى لدرجة الحرارة');
            $table->integer('humidity_min')->nullable()->comment('الحد الأدنى للرطوبة %');
            $table->integer('humidity_max')->nullable()->comment('الحد الأعلى للرطوبة %');

            // الشمس
            $table->integer('sun_hours_min')->nullable()->comment('الحد الأدنى لساعات الشمس');
            $table->integer('sun_hours_max')->nullable()->comment('الحد الأعلى لساعات الشمس');

            // الزراعة والحصاد (أشهر 1-12)
            $table->tinyInteger('planting_start_month')->nullable()->comment('شهر بداية الزراعة');
            $table->tinyInteger('planting_end_month')->nullable()->comment('شهر نهاية الزراعة');
            $table->tinyInteger('harvest_start_month')->nullable()->comment('شهر بداية الحصاد');
            $table->tinyInteger('harvest_end_month')->nullable()->comment('شهر نهاية الحصاد');

            // المسافات
            $table->integer('spacing_cm')->nullable()->comment('المسافة بين النباتات (سم)');

            // نصوص حرة
            $table->text('fertilization_notes')->nullable()->comment('إرشادات التسميد');
            $table->text('common_diseases')->nullable()->comment('الأمراض والآفات الشائعة');

            $table->timestamps();

            // قيد التميز: نبات واحد في منطقة واحدة فقط
            $table->unique(['plant_id', 'region_id']);

            // فهارس إضافية (مهمة في PostgreSQL)
            $table->index(['region_id', 'plant_id']);
            $table->index('planting_start_month');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('plant_region_profiles');
    }
};
