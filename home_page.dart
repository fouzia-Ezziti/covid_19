import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data_source.dart';
import 'package:untitled/panels/info_panel.dart';
import 'package:untitled/panels/world_wide_panel.dart';
import 'package:http/http.dart' as http;

import 'pages/country_page.dart';
import 'panels/most_effected_countries.dart';

class HomePage  extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    Map worldData ={}  ;
  fetchWorldWideData() async{

    var url = Uri.parse("https://corona.lmao.ninja/v2/all");
    http.Response response = await http.get(url);
    setState(() {
      worldData = json.decode(response.body);
    });

  }


    List countriesData=[]  ;
    fetchCountriesData() async{

      var url = Uri.parse("https://corona.lmao.ninja/v2/countries?sort=cases");
      http.Response response = await http.get(url);
      setState(() {
        countriesData = json.decode(response.body);
      });

    }

  @override

  void initState(){

    super.initState();
    fetchWorldWideData();
    fetchCountriesData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('covid-19 panel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              color: Colors.orange[100],
              child: Text(
                  DataSource.quote,
                  style:TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text(
                    'worldWide',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryBlack,
                      ),

                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Regional',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                  ),
                ]
              )

            ),
            worldData==null? CircularProgressIndicator() : WorldWidePanel(worldWide: worldData,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Most affected Countries',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
            SizedBox(height: 10,),
            countriesData==null? Container() : MostAffectedPanel(countryData: countriesData,),
            SizedBox(height: 5,),
            InfoPanel(),
            SizedBox(height: 10,),
            Center(
              child: Text('WE ARE TOGETHER IN THIS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: primaryBlack
              ),),
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}


