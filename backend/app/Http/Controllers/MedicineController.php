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
            //  store log if we want
         if ($request->hasFile('image')){
             $request->file('image')->store('logos','public');
          }
        return response()->json($medicine, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        return Medicine::find($id);
    }
    public function search($search)
    {

        return Medicine::where('category', 'like', '%'.$search.'%')
        ->orwhere('manufacturing_company', 'like', '%'.$search.'%')
        ->orwhere('slug', 'like', '%'.$search.'%')
        ->orwhere('scientific_name', 'like', '%'.$search.'%')
        ->orwhere('commercial_name', 'like', '%'.$search.'%')->get();
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
