<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PlantRegionProfile extends Model
{
    protected $fillable = [
        'plant_id',
        'region_id',
        'soil_type',
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

    /**
     * تحويل أنواع الحقول تلقائياً.
     */
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

    /**
     * علاقة: هذا السجل ينتمي إلى نبات واحد.
     */
    public function plant(): BelongsTo
    {
        return $this->belongsTo(Plant::class);
    }

    /**
     * علاقة: هذا السجل ينتمي إلى منطقة واحدة.
     */
    public function region(): BelongsTo
    {
        return $this->belongsTo(Region::class);
    }
}
