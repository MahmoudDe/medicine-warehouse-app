<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Medicine;

class MedicineController extends Controller
{
    public function index()
    {
        $medicines = Medicine::all()->filter(function ($medicine) {
            return $medicine;
            // return $medicine->quantity > 0;

        });

        return response()->json($medicines);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'categories_id' => 'required|integer|exists:categories,id',
            'scientific_name' => 'required|max:255',
            'commercial_name' => 'required|max:255',
            'category' => 'required|max:255',
            'manufacturer' => 'required|max:255',
            'quantity' => 'required|integer',
            'expiry_date' => 'required|date',
            'price' => 'required|numeric',
        ]);

        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('logos', 'public');
            $validatedData['image'] = $path;
        }

        $medicine = Medicine::create($validatedData);

        return response()->json($medicine, 201);
    }

    public function show(string $id)
    {
        $medicine = Medicine::find($id);

        if ($medicine === null) {
            return response()->json(['message' => 'Medicine not found'], 404);
        }

        return $medicine;
    }

    public function search($search)
    {
        return Medicine::where(function ($query) use ($search) {
            $query->where('category', 'like', '%' . $search . '%')
                ->orwhere('manufacturer', 'like', '%' . $search . '%')
                ->orwhere('slug', 'like', '%' . $search . '%')
                ->orwhere('scientific_name', 'like', '%' . $search . '%')
                ->orwhere('commercial_name', 'like', '%' . $search . '%');
        })->where('quantity', '>', 0) // only include medicines with a quantity greater than 0
            // })
            ->get();
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Medicine $medicine)
    {
        $validatedData = $request->validate([
            'categories_id' => 'required|integer|exists:categories,id',
            'scientific_name' => 'required|max:255',
            'commercial_name' => 'required|max:255',
            'category' => 'required|max:255',
            'manufacturer' => 'required|max:255',
            'quantity' => 'required|integer',
            'expiry_date' => 'required|date',
            'price' => 'required|numeric',
        ]);

        $medicine->update($validatedData);

        return response()->json($medicine);
    }

    public function destroy(Medicine $medicine)
    {
        if ($medicine->quantity <= 0) {
            return response()->json(['message' => 'Cannot delete medicine with zero quantity'], 400);
        }

        $medicine->delete();

        return response()->json(null, 204);
    }

}
