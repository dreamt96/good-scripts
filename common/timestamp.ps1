return (([DateTime]::Now.ToUniversalTime().Ticks - 621355968000000000) / 10000000).tostring().Substring(0, 10)