<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProductController;
use Illuminate\Support\Facades\Route;
use App\Models\User;

// Test route to verify API is working
Route::get('test', function() {
    return response()->json(['message' => 'API is working']);
});

// Public routes (no authentication needed)
Route::post('login', [AuthController::class, 'login']);
Route::post('register', [AuthController::class, 'register']);

// Protected routes (require authentication)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('logout', [AuthController::class, 'logout']);
    Route::apiResource('products', ProductController::class);
});

// Debug route
Route::get('debug/users', function() {
    return User::all();
});