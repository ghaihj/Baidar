<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;

class Plant extends Model
{
    protected $fillable = [
        'name_ar',
        'name_en',
        'region_name_ar',
        'region_name_en',
        'season',
        'category_id',
        'description_ar',
        'description_en',
        'image',
        'soil_type_ar',
        'soil_type_en',
        'soil_ph_min',
        'soil_ph_max',
        'water_amount_mm',
        'watering_frequency',
        'temp_min_c',
        'temp_max_c',
        'humidity_min',
        'humidity_max',
        'sun_hours_min',
        'sun_hours_max',
        'planting_start_month',
        'planting_end_month',
        'harvest_start_month',
        'harvest_end_month',
        'spacing_cm',
        'fertilization_notes',
        'common_diseases',
    ];

    protected $casts = [
        'soil_ph_min' => 'decimal:1',
        'soil_ph_max' => 'decimal:1',
        'temp_min_c' => 'decimal:1',
        'temp_max_c' => 'decimal:1',
        'water_amount_mm' => 'integer',
        'humidity_min' => 'integer',
        'humidity_max' => 'integer',
        'sun_hours_min' => 'integer',
        'sun_hours_max' => 'integer',
        'planting_start_month' => 'integer',
        'planting_end_month' => 'integer',
        'harvest_start_month' => 'integer',
        'harvest_end_month' => 'integer',
        'spacing_cm' => 'integer',
    ];

    // العلاقة مع الفئة
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    // Accessor لرابط الصورة الكامل
    protected function imageUrl(): \Illuminate\Database\Eloquent\Casts\Attribute
    {
        return \Illuminate\Database\Eloquent\Casts\Attribute::make(
            get: fn() => $this->image ? asset('storage/' . $this->image) : null,
        );
    }

    // ==========================================
    // الفلاتر (Scopes) - لاستخدامها في الـ API
    // ==========================================

    /**
     * فلترة حسب المنطقة (شمالي، جنوبي، ساحلي، وسطى)
     */
    public function scopeByRegion(Builder $query, string $region): Builder
    {
        return $query->where('region_name_ar', 'like', "%{$region}%")
            ->orWhere('region_name_en', 'like', "%{$region}%");
    }

    /**
     * فلترة حسب الفصل (صيف، شتاء، خريف، ربيع)
     */
    public function scopeBySeason(Builder $query, string $season): Builder
    {
        return $query->where('season', 'like', "%{$season}%");
    }

    /**
     * البحث بالاسم (عربي أو إنجليزي)
     */
    public function scopeSearch(Builder $query, string $term): Builder
    {
        return $query->where(function ($q) use ($term) {
            $q->where('name_ar', 'like', "%{$term}%")
                ->orWhere('name_en', 'like', "%{$term}%");
        });
    }
}
