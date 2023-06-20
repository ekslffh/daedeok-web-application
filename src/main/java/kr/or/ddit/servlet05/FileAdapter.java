package kr.or.ddit.servlet05;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;

import javax.servlet.ServletContext;

/**
 * FileAdapter - FileWrapper 
 *
 */
public class FileAdapter implements Serializable {
	private transient File adaptee;

	public FileAdapter(File adaptee, ServletContext application) throws IOException {
		super();
		this.adaptee = adaptee;
		this.name = adaptee.getName();
		this.clzValue = adaptee.isDirectory() ? "dir" : "file";
		int contextPathLength = application.getRealPath("/").length();
		this.logicalPath = adaptee.getCanonicalPath().substring(contextPathLength-1)
					.replace(File.separator, "/");
	}
	
	private String name;
	private String clzValue;
	private String logicalPath;

	public String getName() {
		return name;
	}
	public String getClzValue() {
		return clzValue;
	}
	public String getLogicalPath() {
		return logicalPath;
	}
	
	@Override
	public String toString() {
		return "FileAdapter [name=" + name + ", clzValue=" + clzValue + ", logicalPath=" + logicalPath + "]";
	}
	
}