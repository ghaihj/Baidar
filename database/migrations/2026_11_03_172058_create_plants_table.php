<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('plants', function (Blueprint $table) {
            $table->id();
            $table->string('name_ar', 150)->index()->comment('الاسم العربي');
            $table->string('name_en', 150)->nullable()->comment('الاسم الإنجليزي');
            $table->foreignId('category_id')->constrained()->cascadeOnDelete();
            $table->text('description')->nullable()->comment('وصف موجز');
            $table->string('image_url', 500)->nullable()->comment('رابط الصورة التوضيحية');
            $table->timestamps();

            $table->index('category_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('plants');
    }
};
