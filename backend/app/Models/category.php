<?php

namespace App\Models;

use App\Models\Medicine;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class category extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'logo'
        //description
    ];

    public function  medcinien(){
        return $this->HasMany(Medicine::class,'categories_id');
    }
}
