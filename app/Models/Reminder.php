<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Str;

class Reminder extends Model
{
    protected $fillable = [
        'uuid',
        'user_plant_id',
        'type',
        'next_due_at',
        'frequency_days',
        'is_active',
    ];

    protected $casts = [
        'next_due_at' => 'datetime',
        'frequency_days' => 'integer',
        'is_active' => 'boolean',
    ];

    protected static function booted(): void
    {
        static::creating(function ($model) {
            if (empty($model->uuid)) {
                $model->uuid = (string) Str::uuid();
            }
        });
    }

    public function userPlant(): BelongsTo
    {
        return $this->belongsTo(UserPlant::class);
    }
}
