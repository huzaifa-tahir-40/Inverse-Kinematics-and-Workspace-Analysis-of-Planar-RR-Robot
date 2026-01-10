/*
 * Copyright (c) 2026 Huzaifa Tahir, Aymen Jamil
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 */


#include <Servo.h>
//Define Servo Pins
#define servo_1_pin 9
#define servo_2_pin 10

Servo F1;
Servo F2;

double q[2][2];
int q1_up = 0; int q2_up = 0;
int q1_down = 0; int q2_down = 0;
//Lengths of Links
double a1 = 10;
double a2 = 10;

int q1; int q2;

void setup() {
  // Initialize Serial Communication
  Serial.begin(9600);
  // Initialize Servo Motors
  F1.attach(servo_1_pin);
  F2.attach(servo_2_pin);
  //Serial.println("Enter x y coordinates: ");
}
void loop()
{
  // Write the required functionality
  Serial.println("Enter x, y: ");
  while (Serial.available() == 0) { }   // wait
  double x = Serial.parseFloat();
  double y = Serial.parseFloat();  

  delay(1000);
  // Compute IK
  ik_planar_2dof(x, y, a1, a2, q);

  q1_down = q[0][0]; q2_down = q[0][1];
  q1_up = q[1][0];   q2_up = q[1][1];

  if(q1_down <= 180 && q2_down <= 180 && q1_down > 0 && q2_down > 0)
  {
    q1 = q1_down;
    q2 = q2_down;
    move_robot(q1,abs(q2));
  }
  else if(q1_up <= 180 && q2_up <= 180 && q1_up > 0 && q2_up > 0 )
  {
    q1 = q1_up;
    q2 = q2_up;
    move_robot(q1,abs(q2));
  }
  else
  {
    Serial.println("Unreachable");
  }

  Serial.println("============ Angles ===============");
  Serial.print("q_1 = "); Serial.println(q1);
  Serial.print("q_2 = "); Serial.println(q2);
}
