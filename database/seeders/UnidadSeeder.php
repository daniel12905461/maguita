<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Unidad;

class UnidadSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        $lb = new Unidad();
        $lb->nombre = 'lb';
        $lb->save();

        $kg = new Unidad();
        $kg->nombre = 'kg';
        $kg->save();

        $arroba = new Unidad();
        $arroba->nombre = 'Arroba';
        $arroba->save();
    }
}
