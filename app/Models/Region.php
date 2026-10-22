<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Region extends Model
{
    protected $fillable = ['name_ar', 'name_en', 'climate_zone'];

    /**
     * علاقة: المنطقة الواحدة لها عدة سجلات بيانات نباتات.
     */
    public function plantProfiles()
    {
        return $this->hasMany(PlantRegionProfile::class);
    }
}
