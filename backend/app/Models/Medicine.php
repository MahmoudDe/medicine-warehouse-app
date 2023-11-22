<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

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
        'category',
        'manufacturing_company',
        'quantities',
        'expiry_date',
        'price',
        'slug',
    ];
}
