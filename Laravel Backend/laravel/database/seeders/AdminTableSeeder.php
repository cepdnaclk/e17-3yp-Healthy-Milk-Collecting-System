<?php

namespace Database\Seeders;
use App\Models\Admin;
use Illuminate\Database\Seeder;

class AdminTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $admin =[
            'name'=>'Aminda Amarasinghe',
            'email'=>'e17012@eng.pdn.ac.lk',
            'contact'=>'0714177300',
            'password'=>bcrypt('aminda12@milktab'),
        ];
        Admin::create($admin);
    }
}
