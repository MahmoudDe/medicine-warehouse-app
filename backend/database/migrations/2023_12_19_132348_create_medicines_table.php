<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMedicinesTable extends Migration
{
    /**
     * Run the migrations.  
     *
     * @return void
     */
    public function up()
    {
        Schema::create('medicines', function (Blueprint $table) {
            $table->id();
            $table->foreignId('categories_id')->constrained()->onDelete('cascade'); 
            $table->string('scientific_name')->default('default scientific name');
            $table->string('commercial_name')->default('default commercial name');
            $table->string('category')->default('default category');
            $table->string('manufacturer')->default('default company');
            $table->string('image')->nullable();
            $table->integer('quantity')->default(0);
            $table->date('expiry_date')->default(date('Y-m-d'));
            $table->decimal('price', 8, 2)->default(0.00);
            $table->string('slug')->unique();
            $table->string('logo')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('medicines');
    }
}
