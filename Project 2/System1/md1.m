function dx = md1(t,x,am,gamma,a,b,u)

dx( 1 ) = -a * x( 1 ) + b * u( t );
dx( 2 ) = gamma * ( x( 1 ) - x( 6 ) ) * x( 4 );
dx( 3 ) = gamma * ( x( 1 ) - x( 6 ) ) * x( 5 );
dx( 4 ) = -am * x( 4 ) + x( 1 );
dx( 5 ) = -am * x( 5 ) + u( t );
dx( 6 ) = ( x( 2 ) - am ) * x( 6 ) + x( 3 ) * u( t );
    
dx = dx';
end

