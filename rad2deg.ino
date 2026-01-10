float pi = 3.1428;

float rad2deg(double rad)
{
  return int(round(rad * 180.0 / pi));
}