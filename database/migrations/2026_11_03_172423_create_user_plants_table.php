<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_plants', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique()->comment('معرف فريد يولده التطبيق');
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('plant_id')->constrained()->cascadeOnDelete();
            $table->foreignId('region_id')->constrained()->cascadeOnDelete();

            $table->date('planted_at')->nullable()->comment('تاريخ الزراعة الفعلي');
            $table->text('notes')->nullable()->comment('ملاحظات المستخدم');

            $table->timestamps();

            // فهارس مهمة في PostgreSQL
            $table->index(['user_id', 'plant_id']);
            $table->index('user_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_plants');
    }
};
