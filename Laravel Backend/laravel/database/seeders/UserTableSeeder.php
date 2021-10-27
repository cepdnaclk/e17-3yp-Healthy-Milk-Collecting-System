<?php

namespace Database\Seeders;
use App\Models\User;
use App\Models\Collector;
use App\Models\Farmer;
use Illuminate\Database\Seeder;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $users =array(
        [
            'email' => 'samansilva3@gmail.com',
            'name' => 'saman',
            'password' => bcrypt('ssp@milk'),
            'firstname' => 'saman',
            'lastname' => 'silva',
            'address' => 'main road, ibbagamuwa',
            'contact' =>'0723456789',
            'type' => 'collector',
            'businesstype' => 'small scale',
        ],
        [
            'email' => 'piyal96@gmail.com',
            'name' => 'piyal',
            'password' => bcrypt('piyal23milk'),
            'firstname' => 'piyal',
            'lastname' => 'ranaweera',
            'address' => 'main road, kekirawa',
            'contact' => '0713456789',
            'type' => 'collector',
            'businesstype' => 'small scale',
        ],
        [
            'email' => 'test1@gmail.com',
            'name' => 'test_user',
            'password' => bcrypt('testpwd'),
            'firstname' => 'test',
            'lastname' => 'user',
            'address' => 'main street, ja-ela',
            'contact' => '0723456789',
            'type' => 'collector',
            'businesstype' => 'collector',
        ],
        [
            'email' => 'sugath21@gmail.com',
            'name' => 'sugath',
            'password' => bcrypt('ssperera'),
            'firstname' => 'sugath',
            'lastname' => 'perera',
            'address' => 'rakwana',
            'contact' => '0723456732',
            'type' => 'farmer',
            'businesstype' => 'cow',
        ],
        [
            'email' => 'tharakau@gmail.com',
            'name' => 'tharaka',
            'password' => bcrypt('ththaraka'),
            'firstname' => 'tharaka',
            'lastname' => 'sampath',
            'address' => 'habarana',
            'contact' => '071556787',
            'type' => 'farmer',
            'businesstype' => 'buffallo',
        ],
        [
            'email' => 'poornap@gmail.com',
            'name' => 'poorna',
            'password' => bcrypt('poornath'),
            'firstname' => 'poorna',
            'lastname' => 'prasad',
            'address' => 'ranna',
            'contact' => '0763355743',
            'type' => 'collector',
            'businesstype' => 'collector',
        ]);
        foreach($users as $user_){
            $user = User::create($user_);
            if($user->type=='collector'){
            
                $collector_creds=[
                 'user_id' => $user->id
                ]; 
                try{
                     $collector=Collector::create($collector_creds);
                     
                }catch(\Throwable $th){
 
                }
             }
             else if($user->type=='farmer'){
                 $farmer_creds=[
                  'user_id' => $user->id
                 ]; 
                 try{
                      $farmer = Farmer::create($farmer_creds);
                      
                 }catch(\Throwable $th){
  
                 }
              }
        }

    }
}
