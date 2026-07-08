<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Producto;
use Faker\Factory as Faker;

class ProductoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        $producto = new Producto();
        $producto->nombre = 'Toyota Hiace';
        $producto->image = null;
        $producto->save();
        
        $faker = Faker::create('es_ES'); 

        for ($i = 1; $i <= 50; $i++) {
            $producto = new Producto();
            $producto->nombre = $faker->name;
            $producto->image = 'https://www.shutterstock.com/shutterstock/photos/2656041327/display_1500/stock-photo-young-asian-glasses-woman-holding-a-book-listening-to-music-in-headphones-on-bench-in-park-or-2656041327.jpg';
            $producto->save();
        }
    }
}
