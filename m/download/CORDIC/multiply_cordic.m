function z = multiply_cordic ( x, y )

%*****************************************************************************80
%
%% MULTIPLY_CORDIC computes Z=X*Y the CORDIC method.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    27 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Jean-Michel Muller,
%    Elementary Functions: Algorithms and Implementation,
%    Second Edition,
%    Birkhaeuser, 2006,
%    ISBN13: 978-0-8176-4372-0,
%    LC: QA331.M866.
%
%  Parameters:
%
%    Input, real X, Y, the factors.
%
%    Output, real Z, the product.
%
  z = 0.0;
%
%  Easy result if X or Y is zero.
%
  if ( x == 0.0 )
    return
  end

  if ( y == 0.0 )
    return
  end
%
%  X = X_SIGN * X_ABS.
%
  if ( x < 0.0 )
    x_sign = -1.0;
    x_abs = - x;
  else
    x_sign = +1.0;
    x_abs = x;
  end
%
%  X = X_SIGN * X_ABS * 2^X_LOG2
%
  x_log2 = 0;
  while ( 2.0 <= x_abs )
    x_abs = x_abs / 2.0;
    x_log2 = x_log2 + 1;
  end

  while ( x_abs < 1.0 )
    x_abs = x_abs * 2.0;
    x_log2 = x_log2 - 1;
  end
%
%  X*Y = X_SIGN * sum ( 0 <= i) X_ABS(i) * 2^(-i) * Y ) * 2^X_LOG2
%  where X_ABS(I) is the I-th binary digit in expansion of X_ABS.
%
  two_power = 1.0;
  while ( 0.0 < x_abs )
    if ( 1.0 <= x_abs )
      x_abs = x_abs - 1.0;
      z = z + y * two_power;
    end
    x_abs = x_abs * 2.0;
    two_power = two_power / 2.0;
  end
%
%  Account for X_SIGN and X_LOG2.
%
  z = z * x_sign;

  while ( 0 < x_log2 )
    z = z * 2.0;
    x_log2 = x_log2 - 1;
  end

  while ( x_log2 < 0 )
    z = z / 2.0;
    x_log2 = x_log2 + 1;
  end
 
  return
end

