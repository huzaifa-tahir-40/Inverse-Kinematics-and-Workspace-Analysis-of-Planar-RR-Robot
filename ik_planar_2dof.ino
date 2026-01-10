#include <math.h>

void ik_planar_2dof( double x,  double y,  double a1,  double a2,  double q[2][2])
{
   double cos_q2 = (x*x + y*y - a1*a1 - a2*a2) / (2 * a1 * a2); // ... //Equation for Cos Thetha 2
   double sin_q2 = sqrt(1 - cos_q2*cos_q2);// ... //
   double q2_down = atan2(sin_q2, cos_q2);
   double q2_up = atan2(-sin_q2, cos_q2);

  // Down
  double k1 = a1 + a2 * cos_q2;
  double k2 = a2 * sin_q2;       // + means down

  double cos_q1 = (k1*x+k2*y) / (k1*k1 + k2*k2);
  double sin_q1 = (k1*y-k2*x) / (k1*k1 + k2*k2);

  double q1_down = atan2(sin_q1, cos_q1);

  Serial.println("=============== IK Calculations ==================");
  Serial.println("=============== UP ==================");
  Serial.print("cos_q1 = "); Serial.println(cos_q1);
  Serial.print("sin_q1 = "); Serial.println(sin_q1);
  Serial.print("cos_q2 = "); Serial.println(cos_q2);
  Serial.print("sin_q2 = "); Serial.println(sin_q2);
  Serial.print("k1 = "); Serial.println(k1);
  Serial.print("k2 = "); Serial.println(k2);
  

  // Up
  k1 = a1 + a2 * cos_q2;
  k2 = a2 * (-sin_q2);      // - means up

  cos_q1 = (k1*x+k2*y) / (k1*k1 + k2*k2);
  sin_q1 = (k1*y-k2*x) / (k1*k1 + k2*k2);
  double q1_up = atan2(sin_q1, cos_q1);

  Serial.println("=============== DOWN ==================");
  Serial.print("cos_q1 = "); Serial.println(cos_q1);
  Serial.print("sin_q1 = "); Serial.println(sin_q1);
  Serial.print("cos_q2 = "); Serial.println(cos_q2);
  Serial.print("sin_q2 = "); Serial.println(-sin_q2);
  Serial.print("k1 = "); Serial.println(k1);
  Serial.print("k2 = "); Serial.println(k2);

  Serial.println("=============== END =================");

  q[0][0] = rad2deg(q1_down); q[0][1] = rad2deg(q2_down);
  q[1][0] = rad2deg(q1_up);   q[1][1] = rad2deg(q2_up);
}