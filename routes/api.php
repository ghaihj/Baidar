<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\PasswordResetController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::controller(AuthController::class)->group(function () {
    Route::post('/register', 'register');
    Route::post('/login', 'login');
    Route::post('/logout', 'logout');
    Route::get('/me', 'me');
});

Route::middleware('throttle:3,1')->group(function () {
    Route::post('/forgot-password', [PasswordResetController::class, 'forgotPassword']);
    Route::post('/verify-reset-code', [PasswordResetController::class, 'verifyResetCode']);
    Route::post('/reset-password', [PasswordResetController::class, 'resetPassword']);
});

Route::controller(CategoryController::class)->prefix('categories')->group(function () {
    Route::get('', 'index');
    Route::get('{category}', 'show')->middleware('auth:sanctum');
    Route::post('', 'store');
    Route::get('{category}/plants', 'plantsCategory')->middleware('auth:sanctum');
});

Route::controller(\App\Http\Controllers\PlantController::class)->prefix('plants')->group(function () {
    Route::get('', 'index')->middleware('auth:sanctum');
    Route::get('{plant}', 'show')->middleware('auth:sanctum');
    Route::post('', 'store')->middleware('auth:sanctum');
});

Route::controller(\App\Http\Controllers\ProfileController::class)->prefix('profile')->group(function () {
    Route::get('', 'index')->middleware('auth:sanctum');
    Route::get('{user}', 'show')->middleware('auth:sanctum');
    Route::put('{user}', 'update')->middleware('auth:sanctum');
    Route::delete('{user}', 'destroy')->middleware('auth:sanctum');
});
