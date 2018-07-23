<?php

namespace Brazda\Models;

class Settings extends Base
{

	public function enumeration()
	{
		return $this->db->query(
			'SELECT *
			 FROM settings_view
			 ORDER BY setting'
		)->fetchPairs('setting', 'value');
	} // enumeration()

	public function get($name)
	{
		return $this->db->query(
			'SELECT value
			 FROM settings_view
			 WHERE setting LIKE %s'
		)->fetch('value');
	} // get()

	public function set($name, $value = null)
	{
		return $this->db->query(
			'INSERT INTO settings (setting, `value`)
			 VALUES (%s', $name, ', %sN', $value, ')
			 ON CONFLICT (setting) DO
			 UPDATE SET `value` = %sN', $value
		); // query()
	} // set()

} // Settings()
