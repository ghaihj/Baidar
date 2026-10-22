<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reminders', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique()->comment('معرف فريد يولده التطبيق');
            $table->foreignId('user_plant_id')->constrained()->cascadeOnDelete();

            $table->string('type', 20)->comment('نوع التذكير: watering أو fertilizing');
            $table->timestampTz('next_due_at')->comment('وقت التنفيذ التالي (مع المنطقة الزمنية)');
            $table->integer('frequency_days')->nullable()->comment('الفاصل الزمني بالأيام');
            $table->boolean('is_active')->default(true)->comment('هل التذكير مفعل؟');

            $table->timestamps();

            // فهارس مهمة
            $table->index(['user_plant_id', 'type']);
            $table->index('next_due_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reminders');
    }
};
