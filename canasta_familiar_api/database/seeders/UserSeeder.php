<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $adminRole = Role::where('slug', 'admin')->first();
        $usuarioRole = Role::where('slug', 'usuario')->first();

        $admin = User::updateOrCreate(
            ['email' => 'admin@admin.com'],
            [
                'name' => 'Administrador',
                'password' => Hash::make('password'),
            ]
        );
        $admin->roles()->sync([$adminRole->id]);

        $usuario = User::updateOrCreate(
            ['email' => 'usuario@usuario.com'],
            [
                'name' => 'Usuario',
                'password' => Hash::make('password'),
            ]
        );
        $usuario->roles()->sync([$usuarioRole->id]);
    }
}