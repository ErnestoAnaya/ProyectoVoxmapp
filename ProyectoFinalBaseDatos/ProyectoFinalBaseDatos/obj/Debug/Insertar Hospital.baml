   M S B A M L   `   `   `  ����Q  MProyectoFinalBaseDatos, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null?$clr-namespace:ProyectoFinalBaseDatosProyectoFinalBaseDatos  5   	   .    (ProyectoFinalBaseDatos.Insertar_Hospital   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   6local$clr-namespace:ProyectoFinalBaseDatos     5   	     � Title$  Insertar_Hospital��5   	   $	��624��6#   $	��466��60   .��5	      � $	��671��6   $	��Top=�6   .+�5
   
   �� -   5         ��Name$
 moph��5
      $��Moph Number��6   $
��Left=�64   $��
61,135,0,0q�6O   $	��Top=�6c   �� 5   
   -   5         ��Name$ moph_tb��5      $
��Left=�6#   $��23��6>   $��
61,161,0,0q�6J    �� TextWrapping$
 Wrap=�6^   $	��Top=�6r   $	��120��6�   �� 5   
   $
��Name��6   $
��Left=�6   $��
61,189,0,0q�6:   $	��Top=�6N   �� 5   
   $��District��6   $
��Left=�6#   $��
61,243,0,0q�6>   $	��Top=�6R   �� 5   
   $��Province��6   $
��Left=�6#   $��
61,297,0,0q�6>   $	��Top=�6R   �� 5   
   $
��Type��6   $
��Left=�6   $��
61,351,0,0q�6:   $	��Top=�6N   �� 5   
   $��	Longitude��6   $
��Left=�6$   $��
61,405,0,0q�6?   $	��Top=�6S   �� 5   
   $��Latitude��6   $
��Left=�6#   $��
63,459,0,0q�6>   $	��Top=�6R   �� 5   
   -   5        $ name_tb��5      $
��Left=�6#   $��23��6>   $��
61,215,0,0q�6J   $
 Wrap=�6^   $	��Top=�6r   $	��120��6�   �� 5   
   -   5        $ district_tb��5      $
��Left=�6'   $��23��6B   $��
61,269,0,0q�6N   $
 Wrap=�6b   $	��Top=�6v   $	��120��6�   �� 5   
   -   5        $ province_tb��5      $
��Left=�6'   $��23��6B   $��
61,323,0,0q�6N   $
 Wrap=�6b   $	��Top=�6v   $	��120��6�   �� 5   
   -   5        $ type_tb��5      $
��Left=�6#   $��23��6>   $��
61,377,0,0q�6J   $
 Wrap=�6^   $	��Top=�6r   $	��120��6�   �� 5   
   -   5        $ longitude_tb��5      $
��Left=�6(   $��23��6C   $��
61,431,0,0q�6O   $
 Wrap=�6c   $	��Top=�6w   $	��120��6�   �� 5   
   -   5        $ latitude_tb��5      $
��Left=�6'   $��23��6B   $��
61,485,0,0q�6N   $
 Wrap=�6b   $	��Top=�6v   $	��120��6�   �� 5   
   $��Altitude��6   $
��Left=�6#   $��
63,513,0,0q�6>   $	��Top=�6R   �� 5   
   $��Label��6   $
��Left=�6    $��264,189,0,0q�6;   $	��Top=�6P   �� 5   
   $��Number of doctors��6   $
��Left=�6,   $��264,243,0,0q�6G   $	��Top=�6\   �� 5   
   -	   5        $ altitude_tb��5      $
��Left=�6'   $��23��6B   $��
63,539,0,0q�6N   $
 Wrap=�6b   $	��Top=�6v   $	��120��6�   �� 5   
   -
   5        $ label_tb��5      $
��Left=�6$   $��23��6?   $��264,215,0,0q�6K   $
 Wrap=�6`   $	��Top=�6t   $	��120��6�   �� 5   
   -   5        $ num_doctors_tb��5      $
��Left=�6*   $��23��6E   $��264,269,0,0q�6Q   $
 Wrap=�6f   $	��Top=�6z   $	��120��6�   �� 5   
   $��Number of staff��6   $
��Left=�6*   $��264,297,0,0q�6E   $	��Top=�6Z   �� 5   
   -   5        $ num_staff_tb��5      $
��Left=�6(   $��23��6C   $��264,323,0,0q�6O   $
 Wrap=�6d   $	��Top=�6x   $	��120��6�   �� 5    
   $��Enter your VoxMapp ID��6   $
��Left=�60   $��	61,33,0,0q�6K   $	��Top=�6^   �� 5!   
   -   5        $ personal_vm_id_tb��5!      $
��Left=�6-   $��23��6H   $��	63,59,0,0q�6T   $
 Wrap=�6g   $	��Top=�6{   $	��120��6�   �� 5"   
   $$��Enter the new hospital's data:��6   $
��Left=�69   $��
61,104,0,0q�6T   $	��Top=�6h   �� 5#   
   -   5         ��Name$ insert_b��5#      $��Insert��6#   $
��Left=�64   $��284,390,0,0q�6O   $	��Top=�6d   $��74��6|   6�   �� 5$   
   -   5        $��<��5$      $
��Left=�6    $��361,547,0,0q�6;   $	��Top=�6P   $��23��6h   6s   5&      5'      