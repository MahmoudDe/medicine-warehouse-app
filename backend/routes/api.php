<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MedicineController;

require __DIR__ . '/auth.php';

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Medicine Routes

// Return All Medicines from Database 
Route::get('/medicines', [MedicineController::class, 'index']);
// To Create New Medicine :: Used By Admin  
Route::post('/medicines', [MedicineController::class, 'store']);
// To Edit Medicine :: Used By Admin
Route::put('/medicines/{medicine}', [MedicineController::class, 'update']);
// To Delete Medicine :: Used By Admin
Route::delete('/medicines/{medicine}', [MedicineController::class, 'destroy']);
// Show By Categories (Filtering)

// Show By one (Medicine Card) 



// User Routes 
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {

    return $request->user();
});



// Order Routes
