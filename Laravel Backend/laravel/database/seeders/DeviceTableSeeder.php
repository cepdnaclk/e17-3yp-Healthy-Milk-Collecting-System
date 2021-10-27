<?php

namespace Database\Seeders;
use App\Models\Device;
use Illuminate\Database\Seeder;

class DeviceTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $devices =array([
            'description'=>'1st',
            'batch'=>'1',
            'status'=>'testing',
        ],
        [
            'description'=>'2nd',
            'batch'=>'1',
            'status'=>'testing',
        ],
        [
            'description'=>'3rd',
            'batch'=>'1',
            'status'=>'testing',
        ],
        );
        foreach($devices as $device){
            Device::create($device);
        }
    }
}
