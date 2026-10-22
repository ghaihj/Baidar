<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Plant extends Model
{
    protected $fillable = ['name_ar', 'name_en', 'category', 'description', 'image_url'];

    /**
     * علاقة: النبات الواحد له عدة سجلات بيانات (واحدة لكل منطقة).
     */
    public function regionProfiles()
    {
        return $this->hasMany(PlantRegionProfile::class);
    }

    /**
     * (اختياري) جلب بيانات نبات معين في منطقة معينة.
     */
    public function profileForRegion(int $regionId): ?PlantRegionProfile
    {
        return $this->regionProfiles()->where('region_id', $regionId)->first();
    }
}
