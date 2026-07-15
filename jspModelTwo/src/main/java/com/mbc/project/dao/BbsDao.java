package com.mbc.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mbc.project.database.DBClose;
import com.mbc.project.database.DBConnection;
import com.mbc.project.dto.BbsDto;

public class BbsDao {

	private static BbsDao dao = new BbsDao();
	
	private BbsDao() {
	}
	
	public static BbsDao getInstance() {
		return dao;
	}
	
	public List<BbsDto> getBbsList() {
		
		String sql = "	select seq, id, ref, step, depth, "
				+ "			title, content, wdate, "
				+ "			del, readcount "
				+ "		from bbs "
				+ "		order by ref desc, step asc ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getBbsList 1/3 success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("getBbsList 2/3 success");
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				int seq = rs.getInt("seq");
				String id = rs.getString("id");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String wdate = rs.getString("wdate");
				int del = rs.getInt("del");
				int readcount = rs.getInt("readcount");
				
				BbsDto dto = new BbsDto(seq, id, ref, step, depth, title, content, wdate, del, readcount);				
				
				list.add(dto);
			}
			System.out.println("getBbsList 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	public List<BbsDto> getBbsList(String category, String keyword) {
		
		String sql = "	select seq, id, ref, step, depth, "
				+ "			title, content, wdate, "
				+ "			del, readcount "
				+ "		from bbs ";
		// 검색
				if(category.equals("title")) {
					sql += " where title like '%" + keyword + "%' ";
				}
				else if(category.equals("content")) {
					sql += " where content like '%" + keyword + "%' ";
				}
				else if(category.equals("writer")) {
					sql += " where id='" + keyword + "' ";
				}		
		
				sql += "		order by ref desc, step asc ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getBbsList 1/3 success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("getBbsList 2/3 success");
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				int seq = rs.getInt("seq");
				String id = rs.getString("id");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String wdate = rs.getString("wdate");
				int del = rs.getInt("del");
				int readcount = rs.getInt("readcount");
				
				BbsDto dto = new BbsDto(seq, id, ref, step, depth, title, content, wdate, del, readcount);				
				
				list.add(dto);
			}
			System.out.println("getBbsList 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	public List<BbsDto> getBbsList(String category, String keyword, int pageNumber) {
		
		String sql = "	select seq, id, ref, step, depth, "
				+ "			title, content, wdate, "
				+ "			del, readcount "
				+ "		from bbs ";
		// 검색
		if(category.equals("title")) {
			sql += " where title like '%" + keyword + "%' ";
		}
		else if(category.equals("content")) {
			sql += " where content like '%" + keyword + "%' ";
		}
		else if(category.equals("writer")) {
			sql += " where id='" + keyword + "' ";
		}		

		sql += "	 order by ref desc, step asc ";
		
		// paging
		sql += " 	 limit 10 offset " + (pageNumber * 10);
				
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getBbsList 1/3 success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("getBbsList 2/3 success");
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				int seq = rs.getInt("seq");
				String id = rs.getString("id");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String wdate = rs.getString("wdate");
				int del = rs.getInt("del");
				int readcount = rs.getInt("readcount");
				
				BbsDto dto = new BbsDto(seq, id, ref, step, depth, title, content, wdate, del, readcount);				
				
				list.add(dto);
			}
			System.out.println("getBbsList 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	// 글의 총수
	public int getAllBbs(String category, String keyword) {
		
		String sql = " select count(*) from bbs ";
		
		// 검색
		if(category.equals("title")) {
			sql += " where title like '%" + keyword + "%' ";
		}
		else if(category.equals("content")) {
			sql += " where content like '%" + keyword + "%' ";
		}
		else if(category.equals("writer")) {
			sql += " where id='" + keyword + "' ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
				
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return count;
	}
	
	
	public boolean bbswrite(BbsDto dto) {
		
		String sql = "	insert into bbs(id, ref, step, depth, "
				+ "				title, content, wdate, del, readcount) "
				+ " 	values(?, (select coalesce(max(ref), 0)+1 from bbs), 0, 0, "
				+ "				?, ?, now(), 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("bbswrite 1/3 success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("bbswrite 2/3 success");
			
			count = psmt.executeUpdate();
			System.out.println("bbswrite 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("bbswrite fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	public BbsDto getBbs(int seq) {
		
		String sql = "	select seq, id, ref, step, depth, "
				+ "			title, content, wdate, "
				+ "			del, readcount "
				+ "		from bbs "
				+ "		where seq = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getBbs 1/3 success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("getBbs 2/3 success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto = new BbsDto(rs.getInt(1), 
								rs.getString(2), 
								rs.getInt(3), 
								rs.getInt(4), 
								rs.getInt(5), 
								rs.getString(6), 
								rs.getString(7), 
								rs.getString(8), 
								rs.getInt(9), 
								rs.getInt(10));
			}
			System.out.println("getBbs 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("getBbs fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}	
	
	public void readcount(int seq) {
		// update
		String sql = " 	update bbs "
				+ "		set readcount = readcount + 1 "
				+ "		where seq = ? ";
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement psmt = null;
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			psmt.executeUpdate();
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}		
	}	
	
	public void answerUpdate(int seq) {
		String sql = " 	update bbs "
				+ "		set step=step+1 "
				+ "		where ref = (select ref from bbs where seq=?) "
				+ "			and step > (select step from bbs where seq=?) ";
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("answerUpdate 1/6 success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("answerUpdate 2/6 success");
			
			psmt.executeUpdate();
			System.out.println("answerUpdate 3/6 success");
			
		} catch (SQLException e) {
			System.out.println("answerUpdate fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}		
	}
	public boolean answerInsert(int seq, BbsDto bbs) {
		String sql = " 	insert into bbs(id, ref, step, depth, "
				+ "				title, content, wdate, del, readcount) "
				+ "		values(?, (select ref from bbs where seq=?), "
				+ "		 		(select step from bbs where seq=?)+1, "
				+ "		 		(select depth from bbs where seq=?)+1, "
				+ "		 		?, ?, now(), 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("answerInsert 4/6 success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bbs.getId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, bbs.getTitle());
			psmt.setString(6, bbs.getContent());
			System.out.println("answerInsert 5/6 success");
			
			count = psmt.executeUpdate();
			System.out.println("answerInsert 6/6 success");
			
		} catch (SQLException e) {
			System.out.println("answerInsert fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	public boolean bbsupdate(BbsDto dto) {
		String sql = "	update bbs "
				+ "		set title=?, content=? "
				+ "		where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("bbsupdate 1/3 success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setInt(3, dto.getSeq());
			System.out.println("bbsupdate 2/3 success");
			
			count = psmt.executeUpdate(); 
			System.out.println("bbsupdate 3/3 success");
			
		} catch (SQLException e) {	
			System.out.println("bbsupdate fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	public int bbsdelete(int seq) {
		String sql = "	update bbs "
				+ "		set del=1 "
				+ "		where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("bbsdelete 1/3 success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("bbsdelete 2/3 success");
			
			count = psmt.executeUpdate();	
			System.out.println("bbsdelete 3/3 success");
			
		} catch (SQLException e) {	
			System.out.println("bbsdelete fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}		
		
		return count;
	}
	
}
