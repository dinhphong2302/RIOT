USE RIOTTEST 
GO 

-- bảng thiếu champion Role 
ALTER TABLE dbo.players
ADD championRole VARCHAR(50);

-- cập nhật champion Role theo từng vị tướng 
UPDATE dbo.players
SET championRole = 
    CASE 
        WHEN championName IN ('Akali', 'Zed', 'Talon', 'Katarina', 'Qiyana', 'Ekko', 'Nocturne',
                              'Fizz', 'Gragas', 'Ahri', 'Akshan', 'Aurora', 'Naafiri', 'Pantheon', 'Viego','Kassadin','Nidalee','Pyke','Sylas') 
        THEN 'Assassin'
        
        WHEN championName IN ('Ahri', 'Viktor', 'Syndra', 'Orianna', 'Azir', 'Lissandra', 
                              'Twisted Fate', 'Veigar', 'Cassiopeia', 'Diana', 'Leblanc', 
                              'Aurelion Sol', 'Ryze', 'Xerath', 'Zoe', 'Malzahar', 'Taliyah', 
                              'Anivia', 'Annie', 'Aurora', 'Hwei', 'Kennen', 'Kayle',
                              'Vladimir', 'Cho’Gath', 'Mel', 'Nunu', 'Nautilus', 'Neeko', 
                              'Singed', 'Swain', 'Teemo', 'Velkoz', 'Zyra', 'Vex','AurelionSol','Chogath','Kassadin','Lux','Nidalee','Rumble','Sylas'
							  ,'TwistedFate') 
        THEN 'Mage - Mid'
        
        WHEN championName IN ('Karma', 'Seraphine', 'Zilean', 'Morgana', 'Rakan', 'Soraka', 
                              'Annie', 'Neeko', 'Velkoz', 'Zyra', 'Milio', 'Veigar','Ivern','Lulu','Lux','TwistedFate') 
        THEN 'Mage - Support'
        
        WHEN championName IN ('Yone', 'Yasuo', 'Mordekaiser', 'Renekton', 'Darius', 'Riven', 
                              'Ambessa', 'Graves', 'Irelia', 'Jayce', 'Volibear', 'Vladimir', 
                              'Nasus', 'Pantheon', 'Sion', 'Tryndamere', 'Viego', 'Lee Sin','Gangplank','Garen','Gwen','Illaoi','Kled','KSante','LeeSin','Sett','XinZhao') 
        THEN 'Fighter'
        
        WHEN championName IN ('Smolder', 'Tristana', 'Ezreal', 'Varus', 'Kaisa', 'Kayle', 
                              'Akshan', 'Azir', 'Corki', 'Zeri', 'Vayne','Caitlyn','Jhin','Kalista') 
        THEN 'Marksman'
        
        WHEN championName IN ('Galio', 'Cho’Gath', 'Zac', 'Malphite', 'Volibear', 'Nasus', 
                              'Nautilus', 'Singed', 'Sion','Chogath','DrMundo','Garen','Illaoi','KSante','Ornn','Poppy') 
        THEN 'Tank'

        ELSE 'Unknown'  -- Nếu không tìm thấy, gán là 'Unknown'
    END;
