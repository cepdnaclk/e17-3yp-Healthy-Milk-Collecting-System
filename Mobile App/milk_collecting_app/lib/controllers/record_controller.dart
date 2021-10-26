import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:milk_collecting_app/Models/sub_record.dart';





class  RecordController extends GetxController{

  

var count = 0.obs;


double ph_value = 0.0;
double fat_rate = 0.0;
double density = 0.0;
double average_temperature = 0.0;
var volume = 0.obs;
var price = 0.obs;
var note = "".obs;


var ph_array = [];
var density_array = [];
var fat_array = [];
var temperature_array = [];

List<SubRecord> subRecords = [];

bool isDefaultFarmer = false;
String defaultFarmer ="";
 bool isDataLoadingViaBlue = true;
 int c = 0;

   increaseC(){
    for(int i=0;i<12;i++){
      sleep(Duration(seconds: 1));
    }

  }

 void _dataLoadingDelay(){
  sleep(Duration(seconds: 8));
   isDataLoadingViaBlue = false;

 }

 


  void increment() {
    count++;
  }

  void addSubRecord(double ph_value,double fat_rate,double density,int volume,int price,double temp,String grade){

    SubRecord subRecord = SubRecord(ph_value, fat_rate, density, volume, price,temp,grade);
    subRecords.add(subRecord);

  }

  void updatePh(double ph_val){
    ph_array.add(ph_val);
    double total = 0;
    for(int i = 0;i<ph_array.length;i++){
      total = total + ph_array[i];
    }
    ph_value = (total/(ph_array.length));  
  }

  void updateVolume(int v) {
    volume = volume + v;
  }

  void updatePrice(int p) {
    price = price + p;
  }

   void updateDensity(double density_val){
    density_array.add(density_val);
    double total = 0;
    for(int i = 0;i<density_array.length;i++){
      total = total + density_array[i];
    }
    density = (total/(density_array.length));  
  }


  void updateFatRate(double fat_val){
    fat_array.add(fat_val);
    double total = 0;
    for(int i = 0;i<fat_array.length;i++){
      total = total + fat_array[i];
    }
    fat_rate = (total/(fat_array.length));  
  }

  void updateTemperature(double temperature){
    temperature_array.add(temperature);
    double total = 0;
    for(int i = 0;i<temperature_array.length;i++){
      total = total + temperature_array[i];
    }
    average_temperature = (total/(temperature_array.length));  
  }



}


