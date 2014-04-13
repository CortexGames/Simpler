package simpler.external
{
	// Flash Classes \/ //
	import flash.sensors.Accelerometer; // Import the Accelerometer Class
	import flash.events.AccelerometerEvent; // Import the AccelerometerEvent Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	
	/**
	 * IRAccelerometer allows for easy access to the Accelerometer of a device.
	 */
	public class IRAccelerometer extends IRObject
	{
		private var m_sAccel:Accelerometer; // Store the Accelerometer
		private var m_xAccel:Number = 0;
		private var m_yAccel:Number = 0;
		private var m_zAccel:Number = 0;
		
		public function IRAccelerometer()
		{	
			if(Accelerometer.isSupported)
			{
				m_sAccel = new Accelerometer(); // Store the Accelerometer
				m_sAccel.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate); // Add Accelerometer Event
			} // Accelerometer Supported
			else
			{
				trace("[Simpler] Error 1007: Accelerometer is not supported on this device!");
			} // Show an error!
		}
		
		private function onAccUpdate(e:AccelerometerEvent):void
		{
			m_xAccel = e.accelerationX;
			m_yAccel = e.accelerationY;
			m_zAccel = e.accelerationZ;
			if(m_sAccel.muted)
			{
				trace("[Simpler] Error 1008: Accelerometer doesn't have permission to run!");
				Destroy();
			}
		} // Update the Acceleration
		
		public override function Destroy():void
		{
			m_sAccel.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			m_sAccel = null;
			super.Destroy();
		} // Deconstructor
		
		/**
		 * Return the X Acceleration of the device.
		 */
		public function get xAcceleration():Number
		{
			return m_xAccel;
		}
		
		/**
		 * Return the Y Acceleration of the device.
		 */
		public function get yAcceleration():Number
		{
			return m_yAccel;
		}
		
		/**
		 * Return the Z Acceleration of the device.
		 */
		public function get zAcceleration():Number
		{
			return m_zAccel;
		}
		
		/**
		 * Is the Accelerometer supported on this device?
		 */
		public function get isSupport():Boolean
		{
			return Accelerometer.isSupported;
		}
	} // Class
} // Package