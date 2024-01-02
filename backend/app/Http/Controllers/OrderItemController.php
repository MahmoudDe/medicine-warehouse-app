<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Medicine;
use App\Models\OrderItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class OrderItemController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        $orderItems = OrderItem::all();
        return response()->json($orderItems);
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $medicine = Medicine::find($request->medicine_id);
        $price = $medicine->price;

        // Check if there's enough quantity of the medicine
        if ($medicine->quantity < $request->quantity) {
            return response()->json(['error' => 'Not enough quantity available'], 400);
        }

        $orderItem = OrderItem::create([
            'order_id' => $request->order_id,
            'medicine_id' => $request->medicine_id,
            'quantity' => $request->quantity,
            'cost' => ($request->quantity * $price)
        ]);

        // Decrease the quantity of the medicine
        $medicine->decrement('quantity', $request->quantity);

        // // Check if the quantity of the medicine is 0
        // if ($medicine->quantity == 0) {
        //     // Delete the medicine from the database
        //     $medicine->delete();
        // }

        $order = Order::find($request->order_id);
        $order->update(['total_amount' => $order->total_amount + $orderItem->cost]);

        return response()->json($orderItem, 201);
    }



    /**
     * Display the specified resource.
     */
    public function show(OrderItem $orderItem)
    {
        return response()->json(OrderItem::find($orderItem));
    }



    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, OrderItem $orderItem)
    {
        $orderItem->update($request->all());
        return response()->json($orderItem);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(OrderItem $orderItem)
    {
        $orderItem->delete();

        return response()->json(null, 204);
    }

    public function getOrder(Order $order)
    {
        $orderItems = OrderItem::where('order_id', 'like', '%' . $order->id . '%')->get();


        return response()->json($orderItems);
    }

   
 public function total(Request $request)
    {
        $startDate = $request->input('startDate');
        $endDate = $request->input('endDate');

        $data = DB::table('orders')
            ->whereBetween('created_at', [$startDate, $endDate])
            ->select(DB::raw('SUM(total_amount) as total_price'))
            ->get();

        $responseData = json_encode($data);

        return response($responseData, 200)
            ->header('Content-Type', 'application/json');
    }
    public function quantity(Request $request)
    {
        $startDate = $request->input('startDate');
        $endDate = $request->input('endDate');

        $data = DB::table('order_items')
            ->whereBetween('created_at', [$startDate, $endDate])
            ->select(DB::raw('SUM(quantity) as total_quantity'))
            ->get();

        $responseData = json_encode($data);

        return response($responseData, 200)
            ->header('Content-Type', 'application/json');
    }
}
