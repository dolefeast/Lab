# orbits.m - calculo de orbitas para problema de uno y dos cuerpos
# INSTRUCCIONES:
# 1) copiar orbits.m a un directorio
# 2) arrancar octave desde el mismo directorio
# 3) introducir la orden:
#      octave:1> orbits
# 4) el programa respondera:
#      Listo. Uso: orbitplot (T, r, epsilon, (m1/m2))
# 5) para calcular los parametros de una orbita:
#      octave:2> orbitplot (T, r, e, z)
#    donde:
#       T - periodo deseado (segundos)
#       r - distancia de perihelio entre los dos planetas
#       e - excentricidad de la orbita (0: circulo, 0 < e < 1: elipse)
#       z - relacion entre las masas (m1/m2). Si z es muy grande o
#           muy pequenya, el problema se reduce al de un cuerpo.

global G = 6.67e-11;
global M1 M2;
# x(1) : x1
# x(2) : y1
# x(3) : x2
# x(4) : y2
# x(5) : x.1
# x(6) : y.1
# x(7) : x.2
# x(8) : y.2

function xdot = f(x,t)
	global M1 M2 G;
	xdot=zeros(8,1);
	xdot(1) = x(5);
	xdot(2) = x(6);
	xdot(3) = x(7);
	xdot(4) = x(8);
	
	
	F = G * M1 * M2 / ((x(1)-x(3))^2+(x(2)-x(4))^2);
	
	alpha = atan2(x(4)-x(2),x(3)-x(1));
	
	xdot(5) = (F / M1) * cos(alpha);
	xdot(6) = (F / M1) * sin(alpha);
	xdot(7) = -(F / M2) * cos(alpha);
	xdot(8) = -(F / M2) * sin(alpha);
endfunction

function orbitplot (T, r, epsilon, m1divm2) 
	
	global M1 M2 G;

	a = r / (1-epsilon)	
	M = 4 * pi^2 * abs(a) ^3  / (G * T^2 )

	v = sqrt (G*M * (1+epsilon)/r)
	
	M1 = M * m1divm2 / (1+m1divm2)
	M2 = M / (1+m1divm2)
	
	x10 = -M2/M * r
	x20 = M1/M * r
	
	vy10 = -M2/M * v
	vy20 = M1/M * v
	
	x0 = [ x10; 0; x20; 0; 0; vy10; 0; vy20 ];
	
	t = linspace (0, T, 200)';
	x = lsode ("f", x0, t);
	axis("equal");
	plot([x(:,1) x(:,3)],[x(:,2) x(:,4)])
endfunction
disp ("Listo. Uso: orbitplot (T, r, epsilon, (m1/m2))");
#ejemplo: orbita circular
#orbitplot (5000, 250, 0, 2/3);


