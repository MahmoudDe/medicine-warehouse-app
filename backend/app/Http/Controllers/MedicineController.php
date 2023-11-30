<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Medicine;

class MedicineController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $medicines = Medicine::all();

        return response()->json($medicines);
    }
    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $medicine = Medicine::create($request->all());

        return response()->json($medicine, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        return Medicine::find($id);
    }
    public function search($category)
    {

        return Medicine::where('category', 'like', '%'.$category.'%')->get();
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Medicine $medicine)
    {
        $medicine->update($request->all());

        return response()->json($medicine);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Medicine $medicine)
    {
        $medicine->delete();

        return response()->json(null, 204);
    }
}
