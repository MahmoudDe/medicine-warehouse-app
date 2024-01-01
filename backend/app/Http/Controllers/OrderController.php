<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Medicine;
use App\Models\OrderItem;
use Illuminate\Database\Eloquent\Casts\Json;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    /**
 * Display a listing of the resource for a specific user.
 */
public function indexForUser($userId)
{
    $orders = Order::where('user_id', $userId)->get();
    return response()->json($orders);
}

    public function index()
    {
        $orders = Order::all();
        return response()->json($orders);
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {

        $order = Order::create([
            'user_id' => $request->user_id,
            'status' => $request->status,
            'date' => $request->date,
            'total_amount' => 0
        ]);

        return response()->json($order, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Order $order)
    {
        return response()->json(Order::find($order));
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Order $order)
    {
        $order->update($request->all());

        return response()->json($order);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Order $order)
    {
        $order->delete();

        return response()->json(null, 204);
    }

    public function acceptOrder(Order $order)
    {

        $order->update(['status' => 'Preparing']);
        $orderItems = OrderItem::where('order_id', '=', $order->id)->get();
        foreach ($orderItems as $orderItem) {
            $medicines = Medicine::where('id', '=', $orderItem->medicine_id)->get();
            foreach ($medicines as $medicine) {
                $medicine->update(['quantities' => ($medicine->quantities - $orderItem->quantity)]);
            }
        }
        return response()->json(['order' => $order, 'Items' => $orderItems]);
    }

    public function rejectOrder(Order $order)
    {

        $order->update(['status' => 'Rejected']);
        return response()->json(null, 204);
    }
}
