<?xml version="1.0" encoding="UTF-8"?>
<ehcache>
    <!-- 缓存数据的路径，java.io.tmpdiv 指的是操作系统的临时目录 -->
    <diskStore path="java.io.tmpdiv"/>
    <!-- 默认的缓存配置，用在当没有配置针对某个对象的缓存时，采用默认的配置 -->
    <!-- maxElementsInMemory 内存中缓存某个对象的最大个数 -->
    <!-- maxElementsOnDisk 磁盘中缓存某个对象的最大个数 -->
    <!-- memoryStoreEvictionPolicy 当达到maxElementsInMemory限制时，Ehcache将会根据指定的策略去清理内存。默认策略是LRU(最近最少使用)。你可以设置为FIFO(先进先出)或是LFU(较少使用) -->
    <!-- eternal 缓存的某个对象是否是永恒的。当它值是true的时候超时设置将被忽略，对象从不过期(timeToIdleSeconds和timeToLiveSeconds的值都无效) -->
    <!-- timeToIdleSeconds 设置对象在失效前允许闲置的时间(单位：秒)，当超过这个时间自动从缓存中清除，当值是0的时候表示无限长 -->
    <!-- timeToLiveSeconds 设置对象在失效前允许存活的时间(单位：秒)，当超过这个时间自动从缓存中清除，当值是0的时候表示无限长 -->
    <!-- overflowToDisk 当缓存某个对象的数量超过 maxElementsInMemory 的值是，是否写入磁盘文件，
    	 如果设置为True，则会将超出的部分写入到<diskStore>标签指定的临时目录中
    -->
    <!-- diskPersistent 是否缓存虚拟机重启期数据 -->
    <!-- diskSpoolBufferSizeMB 这个参数设置DiskStore(磁盘缓存)的缓存区大小，默认是30MB。每个Cache都应该有自己的一个缓冲区 -->

    <defaultCache
            maxElementsInMemory="999"
            maxElementsOnDisk="10000"
            memoryStoreEvictionPolicy="LRU"
            eternal="false"
            timeToIdleSeconds="300"
            timeToLiveSeconds="300"
            overflowToDisk="true"
            diskPersistent="false"
    />
<#if jsonParam.useCacheTables?has_content>
    <#list tableInfoList as tableInfo>
        <#if FtlUtils.tableExisted(tableInfo, jsonParam.useCacheTables)>

    <!-- 用于保存${tableInfo.simpleRemark}数据的Cache -->
    <cache
            name="${tableInfo.lowerCamelCase}Cache"
            maxElementsInMemory="99"
            maxElementsOnDisk="10000"
            memoryStoreEvictionPolicy="LRU"
            eternal="true"
            overflowToDisk="true"
            diskPersistent="false"
    />
        </#if>
    </#list>
</#if>
</ehcache>
