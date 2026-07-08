<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Precio;

class PrecioSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        for ($i = 1; $i <= 51; $i++) {
            for ($j = 1; $j <= 3; $j++) {
                $precio = new Precio();
                $precio->nombre = $j . ',00';
                $precio->producto_id = $i;
                $precio->unidad_id = $j;
                $precio->save();
            }
        }
    }
}
