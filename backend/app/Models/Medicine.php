<?php

namespace App\Models;

use App\Models\category;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Support\Str;

class Medicine extends Model
{
    use HasFactory;

    protected $fillable = [
        'scientific_name',
        'commercial_name',
        'categories_id',
        'manufacturer',
        'image',
        'category',
        'quantity',
        'expiry_date',
        'price',
        'slug',
        'logo'
    ];

    public function category()
    {
       return $this->belongsTo(category::class,'categories_id');
    }
      
    public function setScientificNameAttribute($value)
    {
        $this->attributes['scientific_name'] = $value;
        $this->attributes['slug'] = Str::slug($value);
    }
}
