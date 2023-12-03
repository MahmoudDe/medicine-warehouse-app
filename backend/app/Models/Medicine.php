<?php

namespace App\Models;

use App\Models\category;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Medicine extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'scientific_name',
        'commercial_name',
        'categories_id',
        'manufacturing_company',
        'image',
        'quantities',
        'expiry_date',
        'price',
        'slug',
        'logo'
    ];
    public function category()
    {
       return $this->belongsTo(category::class,'categories_id');
    }
}
