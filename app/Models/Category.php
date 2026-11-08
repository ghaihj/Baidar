<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $fillable = [
        'name_en',
        'name_ar',
        'image',
    ];

    public function plants()
    {
        return $this->hasMany(Plant::class);
    }

    // داخل Category.php
    // protected function imageUrl(): \Illuminate\Database\Eloquent\Casts\Attribute
    // {
    //     return \Illuminate\Database\Eloquent\Casts\Attribute::make(
    //         get: fn() => $this->image ? asset('storage/' . $this->image) : null,
    //     );
    // }
}
