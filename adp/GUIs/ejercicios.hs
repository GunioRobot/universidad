import AP.GUI
import System.Random -- para ejemplos posteriores

-- Ejercicio 1 --

-- :t Position
-- :i Positioned

-- Ejercicio 2 --

-- :i Dialog

-- Ejercicio 3 --
{- 
	Crea una ventana con un tamaño inicial. Se
	duerme unos segundos, modifica su tamaño y
	se vuelve a dormir.
-}

ejercicio3 segundos = gui prog
	where prog = do
	-- inicializar
		ventana <- window 	[title =: "Ejercicio 3"
							,size =: Size 800 600]
		update
		sleep (1000*segundos)
	-- modificar tamaño
		ventana !: size =: Size 600 800
		sleep (1000*segundos)
		quit
		
-- Ejercicio 4 --
{- 
	Ventana que se va moviendo por la pantalla
	durante unos segundos con una trayectoria
	aleatoria.
-}

ejercicio4 = gui prog
	where prog = do
	-- inicializar
		ventana <- window 	[title =: "Ejercicio 4"
							,size =: Size 800 600
							,position =: Point 0 0]
		update
		sleep 1000
	-- modificar posición
		nuevaPosicion <- puntoAleatorio
		ventana !: position =: nuevaPosicion
		sleep 1000
		nuevaPosicion <- puntoAleatorio
		ventana !: position =: nuevaPosicion
		sleep 1000
		nuevaPosicion <- puntoAleatorio
		ventana !: position =: nuevaPosicion
		sleep 1000
		quit

puntoAleatorio :: IO Point
puntoAleatorio = do
					x <- randomRIO (0, 799)
					y <- randomRIO (0, 599)
					return $ Point x y

-- Ejercicio 5 --
{- 
	Crea una ventana de tamaño fijo (no redimensionable)
	colocada en una posición concreta.
-}

ejercicio5 = gui prog
	where prog = do
	-- inicializar
		ventana <- window 	[title =: "Ejercicio 5"
							,size =: Size 800 600
							,resizable =: False
							,position =: Point 0 0
							]
		update
		sleep 10000
		quit
		
-- Ejercicio 6 --
{- 
	Crea una ventana que cambia de color según tenga
	el foco o no y según entre y salga el ratón de la misma.
-}

ejercicio6 = gui prog
	where prog = do
	-- inicializar
		ventana <- window 	[title =: "Ejercicio 6"
							,size =: Size 800 600
							,position =: Point 0 0
							,on windowClose =: quit
							]
		ventana !!: [on mouseEnter =: cambiaColor ventana
					,on mouseExit =: cambiaColor ventana
					,on focusGain =: cambiaColor ventana
					,on focusLoose =: cambiaColor ventana]
		update
		
cambiaColor :: Window -> IO ()
cambiaColor w = do
					color <- colorAleatorio
					w !: bgColor =: color
					return ()
		
colorAleatorio :: IO Color
colorAleatorio = do
					rojo <- randomRIO (0, 255)
					verde <- randomRIO (0, 255)
					azul <- randomRIO (0, 255)
					return $ rgb rojo verde azul
					
-- Ejercicio 7 --
{- 
	Crea una ventana con dimensiones, posicion y color de fondo
	aleatorios.
-}

ejercicio7 = gui prog
	where
		prog = do 
				w <- ventanaAleatoria "ventana"
				w !: on windowClose =: quit
				return ()

ventanaAleatoria :: String -> IO Window
ventanaAleatoria título = 
	do		
		color <- colorAleatorio
		tamaño <- tamañoAleatorio
		posición <- posicionAleatoria
		w <- window [ title =: título
					, bgColor =: color
					, position =: posición
					, size =: tamaño ]
		w !: on windowClose =: close w
		return w
		
tamañoAleatorio :: IO Size
tamañoAleatorio =
	do
		x <- randomRIO (0, 800)
		y <- randomRIO (0, 800)
		return $ Size x y
		
posicionAleatoria :: IO Point
posicionAleatoria = 
	do
		x <- randomRIO (0, 800)
		y <- randomRIO (0, 800)
		return $ pt x y
		
-- Ejercicio 8 --
{- 
	Crea n ventanas aleatorias y las muestra. Una de ellas,
	elegida al azar, termina la aplicación al cerrarse. El
	resto sólo se cierran a ellas mismas.
-}

collage :: Int -> IO ()
collage n = gui prog
	where prog =
				do
					numQuit <- randomRIO (1, n);
					let listaVentanas = [ventanaAleatoria $ "ventana " ++ show i | i <- [1..n], i /= numQuit]
					ventanaQuit <- ventanaAleatoria $ "ventana " ++ show numQuit
					ventanaQuit !: on windowClose =: quit;
					sequence_ listaVentanas
					
-- Ejercicio 9 --
{- 
	Muestra una ventana aleatoria. Cada vez que le damos al botón
	de cerrar, el programa decide aleatoriamente si debe cerrar la
	aplicación o cerrar la ventana y crear otra nueva.
-}

ejercicio9 = gui prog
	where
		prog = do 
				w <- ventanaAleatoria "ventana"
				w !: on windowClose =: cerrarONo w
				return ()
		cerrarONo w = do
						cerrar <- randomIO
						if cerrar
							then quit
							else do
									close w
									prog
									
-- Ejercicio 10 --
{- 
	Muestra una ventana con etiquetas, cuyo tipo de relieve cambia
	al ganar y perder el foco.
-}

relieve = gui prog 
	where
		prog = do 
				w <- window [ title =: "Relieves"
							, bgColor =: white
							, on windowClose =: quit ]
				hola <- label 	[text =: "¡Hola mundo!" 
								, font =: (bold . italic . arial) 26 
								, color =: yellow 
								, bgColor =: blue] w
				adios <- label 	[ text =: "¡Adiós mundo!" 
								, font =: (bold . arial) 26
								, color =: yellow 
								, bgColor =: red ] w
				w !: layout =: hola ^.^ flexible (space (sz 10 10)) ^.^ adios
				w !!: 	[ on focusGain =: relieveHundido hola
						, on focusLoose =: relieveSurco adios] 
		relieveHundido l = l !: relief =: Sunken
		relieveSurco l = l !: relief =: Groove
		
-- Ejercicio 11 --
{- 
	Panel de una calculadora simple usando matrix como layout.
-}

calculadora = gui prog 
	where
		prog = do
				w <- window [ title =: "Calculadora"
							, bgColor =: white
							, on windowClose =: quit ]
				let 
					listaEtiquetas = [creaEtiqueta texto w | texto <- controles]
				controlesCalculadora <- sequence listaEtiquetas
				w !: layout =: matrix 4 controlesCalculadora
				return ()

creaEtiqueta :: String -> Window -> IO Label
creaEtiqueta texto w = do
						etiqueta <-	label	[ text =: texto
											, font =: (bold . arial) 26
											, color =: black
											, bgColor =: white
											, relief =: Ridge] w
						return etiqueta
						
controles :: [String]
controles = [ "7", "8", "9", "*"
			, "4", "5", "6", "/"
			, "1", "2", "3", "+"
			, "%", "0", ".", "-"]
									
-- EJEMPLOS
holaAdios = gui prog 
	where
		prog = do 
				w <- window [title =: "Saludo desde GUI", bgColor =: white, on windowClose =: quit ]
				hola <- label [text =: "¡Hola mundo!" , font =: (bold . italic . arial) 26 , color =: yellow , bgColor =: blue] w
				adios <- label [ text =: "¡Adiós mundo!" , font =: (bold . arial) 26, color =: yellow , bgColor =: red ] w
				w!:layout =: hola ^.^ flexible (space (sz 10 10)) ^.^ adios